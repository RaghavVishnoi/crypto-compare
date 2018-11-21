function meter_circle_init(parent_class){
  var r = 150;
  var circles = document.querySelectorAll('.'+parent_class+' .circle');
  var total_circles = circles.length;
  for (var i = 0; i < total_circles; i++) {
      circles[i].setAttribute('r', r);
  }
   
  /* Set meter's wrapper dimension */
  var meter_dimension = (r * 2) + 100;
  var wrapper = document.querySelector("."+parent_class);
  wrapper.style.width = meter_dimension + "px";
  wrapper.style.height = meter_dimension + "px";
   
  /* Add strokes to circles  */
  var cf = 2 * Math.PI * r;
  var semi_cf = cf / 2;
  var semi_cf_1by3 = semi_cf / 3;
  var semi_cf_2by3 = semi_cf_1by3 * 2;
  document.querySelector("."+parent_class+" .outline_curves")
      .setAttribute("stroke-dasharray", semi_cf + "," + cf);
  document.querySelector("."+parent_class+" .low")
      .setAttribute("stroke-dasharray", semi_cf + "," + cf);
  document.querySelector("."+parent_class+" .avg")
      .setAttribute("stroke-dasharray", semi_cf_2by3 + "," + cf);
  document.querySelector("."+parent_class+" .high")
      .setAttribute("stroke-dasharray", semi_cf_1by3 + "," + cf);
  document.querySelector("."+parent_class+" .outline_ends")
      .setAttribute("stroke-dasharray", 2 + "," + (semi_cf - 2));
  document.querySelector("."+parent_class+" .mask")
      .setAttribute("stroke-dasharray", semi_cf + "," + cf);
   
  /* Bind range slider event*/

}

var slider = document.querySelector("."+parent_class+" .slider");
function range_change_event(parent_class, meter_value) {
	var r = 250;
	var cf = 2 * Math.PI * r;
  var semi_cf = cf / 2;
  var semi_cf_1by3 = semi_cf / 3;
  var semi_cf_2by3 = semi_cf_1by3 * 2;
  var slider = document.querySelector("."+parent_class+" .slider");
  var lbl = document.querySelector("."+parent_class+" .lbl");
  var mask = document.querySelector("."+parent_class+" .mask");
  var meter_needle =  document.querySelector("."+parent_class+" .meter_needle");
    var percent = meter_value
    var meter_value = semi_cf - ((percent * semi_cf) / 100);
    //mask.setAttribute("stroke-dasharray", meter_value + "," + cf);
    meter_needle.style.transform = "rotate(" + 
        (270 + ((percent * 180) / 100)) + "deg)";
}