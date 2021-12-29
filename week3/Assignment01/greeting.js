var message;
function greeting(occasion){
    switch(occasion){
        case 'New_year':
            var message = "Happy New year";
        break;
        
        case 'Christmas':
            message = "Merry christmas";
             
        break;
        
        case 'Birthday':
             message = "Happy Birthday";
            
        break;
        
        case 'Anniversary':
             message = "Happy Anniversary";
            
        break;
        
        default:
            console.log("No occasion");
        break;
        
 
    }
    console.log("On "+ occasion +" "+message);
}
greeting('New_year');
greeting('Christmas');
greeting('Birthday');
greeting('Anniversary');
