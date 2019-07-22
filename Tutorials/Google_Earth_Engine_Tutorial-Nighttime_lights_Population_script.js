
// download country boundary 
var country_boundary = ee.FeatureCollection('USDOS/LSIB/2013')
    .filter(ee.Filter.eq('name', 'BELIZE'));

Map.addLayer(country_boundary, {color: 'FF0000'}, 'Belize');
Map.centerObject(Belize_city,6)

// access nighttime lights data
var dataset = ee.ImageCollection('NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG')
                  .filter(ee.Filter.date('2014-01-01', '2018-01-01'));
var nighttime = dataset.select('avg_rad');
var nighttimeVis = {min: 0.0, max: 40.0};

// add nighttime lights data to maps
Map.addLayer(nighttime, nighttimeVis, 'Nighttime');



// Chart annual time series of mean nighttime lights
// from our VIIRS DNB data
var chart = ui.Chart.image.series({
    imageCollection: nighttime,          // image collection to plot
    region: Belize_city,                 // area of interest (AOI)
    reducer: ee.Reducer.mean(),          // method for summarizing across multiple pixels inside of AOI
    scale: 500,                          // spatial resolution of input data
})
print(chart)  //** Can export the figure or data in the pop-out


// calculate the median image and clip to country boundary
var median_image_clip = nighttime.median().clip(country_boundary)

// add median image to map
Map.addLayer(median_image_clip, nighttimeVis, 'median_clip');

//zoom back out to download
Map.centerObject(country_boundary,7)        


/////////////////////////
// Export image
Export.image.toDrive({
   description:"Belize_median_DNB_2014_2018", //export file name
   image:median_image_clip,                   //data to export
   region:Belize,                   //always add a boundary for the download
   folder:"GEE",                              //name folder on google drive to save to
   crs: "EPSG:4326",                          //contert to lat lon WGS1984
   scale: 500,
   skipEmptyTiles: true,                      //dont download anything that is empty
   maxPixels:9000000000                       // just do this every time
 })
 
 
////////////////////POPULATION///////////////////////////////

// Add and visualize World Pop data for Belize 2010
var pop_blz = ee.Image('WorldPop/POP/BLZ_2010');

// define range of values that you map and the HEX color code
var populationVis = {
  min: 0.0,
  max: 50.0,
  palette: ['24126c', '1fff4f', 'd4ff50'],
};

// add population to map
Map.addLayer(pop_blz, populationVis, 'Population belize');
 
// Export image
Export.image.toDrive({
   description:"Belize_median_POP_2010",      //export file name
   image:pop_blz,                          //data to export
   region:Belize,            //always add a boundary for the download
   folder:"GEE",                              //name folder on google drive to save to
   crs: "EPSG:4326",                          //contert to lat lon WGS1984
   scale: 500,                                //desired resolution
   skipEmptyTiles: true,                      //dont download anything that is empty
   maxPixels:9000000000                       // just do this every time
 })
 
