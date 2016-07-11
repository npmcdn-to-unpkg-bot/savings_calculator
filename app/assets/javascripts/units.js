$(document).ready(function(){
    $("#fuel-type").change(function(){
       fuel_type = $("#fuel-type").val();
      
       if (fuel_type == "Natural Gas") {
       	$("#fuel-unit").html("therms"); 
       } 
       if (fuel_type == "Propane") {
       	$("#fuel-unit").html("gal"); 
       }  
       if (fuel_type == "Butane") {
       	$("#fuel-unit").html("gal"); 
       }  
       if (fuel_type == "Kerosene") {
       	$("#fuel-unit").html("gal"); 
       }  
       if (fuel_type == "Heating Oil") {
       	$("#fuel-unit").html("gal"); 
       }  
       if (fuel_type == "Coal") {
       	$("#fuel-unit").html("tons"); 
       }               
       if (fuel_type == "Electricity") {
       	$("#fuel-unit").html("kW/h"); 
       }
    });        
});