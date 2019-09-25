
anychart.onDocumentReady(function() {

var data = [
{"x":"acetic acid","value":9,category:"Negative"},
{"x":"alcohol","value":5183,category:"Neutral"},
{"x":"almond","value":3390,category:"Positive"},
{"x":"apple","value":11729,category:"Positive"},
{"x":"apricot","value":3957,category:"Positive"},
{"x":"artichoke","value":24,category:"Negative"},
{"x":"asparagus","value":335,category:"Negative"},
{"x":"bacon","value":1769,category:"Positive"},
{"x":"baker's yeast","value":536,category:"Neutral"},
{"x":"banana","value":1171,category:"Neutral"},
{"x":"bell","value":534,category:"Neutral"},
{"x":"black currant","value":12987,category:"Positive"},
{"x":"black pepper","value":9064,category:"Positive"},
{"x":"blackberry","value":14799,category:"Positive"},
{"x":"burned","value":31,category:"Negative"},
{"x":"burnt match","value":699,category:"Negative"},
{"x":"burnt toast","value":8199,category:"Negative"},
{"x":"butterscotch","value":1222,category:"Positive"},
{"x":"cabbage","value":25,category:"Negative"},
{"x":"canned/cooked","value":798,category:"Negative"},
{"x":"caramel","value":3063,category:"Positive"},
{"x":"cedar","value":3802,category:"Positive"},
{"x":"cherry","value":32172,category:"Positive"},
{"x":"chocolate","value":12090,category:"Positive"},
{"x":"citrus","value":16925,category:"Positive"},
{"x":"cloves","value":117,category:"Neutral"},
{"x":"coffee","value":5283,category:"Neutral"},
{"x":"cork","value":109,category:"Negative"},
{"x":"cut green grass","value":1060,category:"Neutral"},
{"x":"diacetyl (butter)","value":1229,category:"Negative"},
{"x":"diesel","value":126,category:"Negative"},
{"x":"dried","value":5996,category:"Neutral"},
{"x":"dusty","value":2768,category:"Negative"},
{"x":"ethyl acetate","value":5,category:"Negative"},
{"x":"eucalyptus","value":445,category:"Positive"},
{"x":"fig","value":1269,category:"Positive"},
{"x":"floral","value":3662,category:"Positive"},
{"x":"fresh","value":16653,category:"Positive"},
{"x":"fruit aromas","value":8643,category:"Neutral"},
{"x":"garlic","value":94,category:"Negative"},
{"x":"geranium","value":16,category:"Neutral"},
{"x":"grapefruit","value":4005,category:"Positive"},
{"x":"green beans","value":163,category:"Negative"},
{"x":"green/black olive","value":1831,category:"Neutral"},
{"x":"hay/straw","value":740,category:"Negative"},
{"x":"hazelnut","value":370,category:"Positive"},
{"x":"honey","value":5053,category:"Positive"},
{"x":"horsey","value":72,category:"Negative"},
{"x":"kerosene","value":29,category:"Negative"},
{"x":"leesy","value":404,category:"Negative"},
{"x":"lemon","value":6831,category:"Neutral"},
{"x":"licorice/anise","value":8318,category:"Neutral"},
{"x":"medicinal","value":794,category:"Negative"},
{"x":"melon","value":4797,category:"Positive"},
{"x":"menthol","value":920,category:"Neutral"},
{"x":"mint","value":3658,category:"Neutral"},
{"x":"molasses","value":557,category:"Positive"},
{"x":"moldy","value":16,category:"Negative"},
{"x":"mousy","value":10,category:"Negative"},
{"x":"mushroom","value":1100,category:"Negative"},
{"x":"natural gas/mercaptain","value":11,category:"Negative"},
{"x":"nutty","value":804,category:"Positive"},
{"x":"oak","value":23165,category:"Positive"},
{"x":"orange blossom","value":1207,category:"Positive"},
{"x":"oxidized","value":266,category:"Negative"},
{"x":"peach","value":8798,category:"Positive"},
{"x":"petroleum","value":65,category:"Negative"},
{"x":"phenolic","value":92,category:"Negative"},
{"x":"pineapple","value":5644,category:"Neutral"},
{"x":"plastic","value":137,category:"Negative"},
{"x":"prune","value":1758,category:"Neutral"},
{"x":"raisin","value":1458,category:"Neutral"},
{"x":"raspberry","value":9892,category:"Positive"},
{"x":"resinous","value":52,category:"Positive"},
{"x":"rose","value":1811,category:"Positive"},
{"x":"rubbery","value":896,category:"Negative"},
{"x":"sauerkraut","value":21,category:"Negative"},
{"x":"skunk","value":4,category:"Negative"},
{"x":"smoky","value":5801,category:"Neutral"},
{"x":"soy sauce","value":297,category:"Negative"},
{"x":"spicy","value":31055,category:"Neutral"},
{"x":"strawberry","value":3632,category:"Positive"},
{"x":"strawberry jam","value":2964,category:"Positive"},
{"x":"sulfur","value":207,category:"Negative"},
{"x":"sulfur dioxide","value":11,category:"Negative"},
{"x":"sweaty","value":325,category:"Negative"},
{"x":"tar","value":1139,category:"Negative"},
{"x":"tea","value":2185,category:"Neutral"},
{"x":"tobacco","value":6303,category:"Negative"},
{"x":"tree fruit","value":13499,category:"Positive"},
{"x":"tropical fruit","value":4132,category:"Positive"},
{"x":"vanilla","value":13680,category:"Positive"},
{"x":"violet","value":1092,category:"Positive"},
{"x":"walnut","value":178,category:"Positive"},
{"x":"wet wool/wet dog","value":77,category:"Negative"},
{"x":"yogurt","value":57,category:"Neutral"}]
;

 // create a tag (word) cloud chart
  var chart = anychart.tagCloud(data);

   // set a chart title
  chart.title('2017 Wine Attributes Weighed by Frequency')

  // set an array of angles at which the words will be laid out
  chart.angles([0])
  // for a more chaotic look, do the following angles:
  // chart.angles([0, -45, 90])

  // enable a color range
  chart.colorRange(true);

  // set the color range length
  chart.colorRange().length('80%');


  // display the word cloud chart
  chart.container("container");
  chart.draw();

// add an event listener
  chart.listen("pointClick", function(e){
  var url = "https://en.wikipedia.org/wiki/" + e.point.get("x");
  window.open(url, "_blank");
});


});
