var text_box = document.getElementById("search_text");
var subject_list = document.getElementById("select_subject");
//var input = document.getElementById("course_table").getElementsByTagName('input');
var input = document.getElementById("course_table");
text_box.addEventListener("keyup", 
	    function() {
        course_query();
    }
 );
//text_box.onkeyup = course_query(text_box.value);
//subject_list.onchange = course_query();

subject_list.addEventListener("change", 
	    function() {
        course_query();
    }
 );

input.addEventListener("change", 
	    function() {
        enroll();
    }
 );


function enroll(){
	var boxes = document.getElementById("course_table").getElementsByTagName('input');
	for (var i = 0; i < boxes.length; i++) {
        if (boxes[i].checked==true) {
	        var host = window.location.origin;
			var path = "/courses/enrollajax";
			var params = boxes[i].id;
			var http = new XMLHttpRequest();
			http.open("GET", host+path+"?"+params, true);
			http.onreadystatechange = function(){
		   		if(http.readyState == 4 && http.status == 200) {
		   			results = JSON.parse(http.responseText);
		   			var message = document.getElementById("alert_message");
		   			if(results =="success"){
		   				message.innerHTML = "Course successfuly enrolled";
		   			}
		   			else if(results =="course already enrolled"){
		   				message.innerHTML = "This course is already enrolled";
		   			}
		   			else{
		   				message.innerHTML = "Could not enroll course";
		   			}
		   		}
			}
			http.send(null);
            
        }
    }
	
}

	function course_query(){
		var host = window.location.origin;
		var path = "/courses/resultsjson";
		var params = "";
		var http = new XMLHttpRequest();

		if(subject_list.value!=""){
			//params += "subject="+subject_list.item(subject_list.value).text + "&"; 
			params += "subject_id="+subject_list.value; 
		}
		if(text_box.value!=""){
			params += "&course_criteria=" + text_box.value;
		}

		if((subject_list.value=="")&&(text_box.value=="")){
			table = document.getElementById("course_table");
			while(table.hasChildNodes())
			{
			   table.removeChild(table.firstChild);
			}
		}
		else{
			http.open("GET", host+path+"?"+params, true);
			http.onreadystatechange = function(){
		   		if(http.readyState == 4 && http.status == 200) {
		   			results = JSON.parse(http.responseText);
		   			create_table(results);
		   		//debugger;
		    	//alert(http.responseText);
		   		}
			}
			http.send(null);
		}
	}

	function create_table(results){
		let set = new Set();
		table = document.getElementById("course_table");
		nrows = table.children.length;
		while(table.hasChildNodes()){
			table.removeChild(table.firstChild);
		}
		for(i=0; i<results.length; i++){
				var row = table.insertRow(i);
				var cell1 = row.insertCell(0);
				var cell2 = row.insertCell(1);
				var cell3 = row.insertCell(2);
				var cell4 = row.insertCell(3);
				cell1.innerHTML = results[i]["id"];
				cell2.innerHTML = results[i]["name"];
				cell3.innerHTML = results[i]["brandeis_code"];

				var objInputCheckBox = document.createElement("input");
				objInputCheckBox.type = "checkbox";
				objInputCheckBox.class = "checkbox";
				objInputCheckBox.id = results[i]["id"];
				objInputCheckBox.checked = 0; 
				cell4.appendChild(objInputCheckBox);
		}
	}