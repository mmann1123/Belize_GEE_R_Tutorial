
/**
 * Function to mask clouds using the Sentinel-2 QA band
 * @param {ee.Image} image Sentinel-2 image
 * @return {ee.Image} cloud masked Sentinel-2 image
 */
function maskS2clouds(image) {
  var qa = image.select('QA60');

  // Bits 10 and 11 are clouds and cirrus, respectively.
  var cloudBitMask = 1 << 10;
  var cirrusBitMask = 1 << 11;

  // Both flags should be set to zero, indicating clear conditions.
  var mask = qa.bitwiseAnd(cloudBitMask).eq(0)
      .and(qa.bitwiseAnd(cirrusBitMask).eq(0));

  return image.updateMask(mask).divide(10000);
}


// Map the function over one year of data and take the median.
// Load Sentinel-2 TOA reflectance data.
var dataset = ee.ImageCollection('COPERNICUS/S2')
                  .filterDate('2018-01-01', '2018-06-30')
                  // Pre-filter to get less cloudy granules.
                  .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
                  .map(maskS2clouds);

var rgbVis = {
  min: 0.0,
  max: 0.3,
  bands: ['B4', 'B3', 'B2'],
};

// add image to map
Map.setCenter(-88.2469,17.5055, 12);
Map.addLayer(dataset.median(), rgbVis, 'RGB');


/////////////////////////
// Storing a variable

// store median and minumum pixel values
var median_image = dataset.median()
var min_image    = dataset.min()

Map.addLayer(median_image, rgbVis, 'median');
Map.addLayer(min_image, rgbVis, 'min');


/////////////////////////
// Clip image


// Get the boundary of Belize from Google's Fusion Table
// Change Country name for different location
var country_boundary = ee.FeatureCollection('USDOS/LSIB/2013')
    .filter(ee.Filter.eq('name', 'BELIZE'));

Map.addLayer(country_boundary, {color: 'FF0000'}, 'Belize');

  
// clip images using country_boundary
var median_image_clip = median_image.clip(country_boundary)
var min_image_clip = min_image.clip(country_boundary)

// add clipped image to maps
Map.addLayer(median_image_clip, rgbVis, 'median_clip');
Map.addLayer(min_image_clip, rgbVis, 'min_clip');



/////////////////////////
// Export image
Export.image.toDrive({
   description:"Belize_median_Sentinel_2017", //export file name
   image:median_image_clip,                   //data to export
   region:country_boundary.bounds,                   //always add a boundary for the download
   folder:"GEE",                              //name folder on google drive to save to
   crs: "EPSG:4326",                          //contert to lat lon WGS1984
   scale: 30,
   skipEmptyTiles: true,                      //dont download anything that is empty
   maxPixels:9000000000                       // just do this every time
 })