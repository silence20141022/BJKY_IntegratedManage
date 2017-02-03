	function checkMoney(x)
	{
	x.value = x.value.replace(/[^\d\\.\,]/g,'');
	//alert(x.value.length);
	 
	}
	
	function checkNumber(x)
	{
	
	x.value = x.value.replace(/[^\d]/g,'');
	
	}

       	function checkTelePhone(x)
	{
	
	x.value = x.value.replace(/[^\d\\-]/g,'');
	
	}
    
    function checkZipCode(x)
    {
      x.value = x.value.replace(/[^\d]/g,'');
      if(x.value.length>6)
      x.value = x.value.substring(0,6);
    }


     function checkEmail(x)
   {
      var pat=/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
      if(x.value.search(pat)==-1)
      { 
        x.style.backgroundColor="red";
        return false;
      }
      else
         {
          x.style.backgroundColor="";
          return true;
          }     
     
   
   }
   
     function checkHTTPURL(x)
   {
      var pat=/http:\/\/([^/:]+)(:\d*)?([^# ]*)/;
      
      if(x.value.search(pat)==-1)
      { 
        x.style.backgroundColor="red";
        return false;
      }
      else
      {
          x.style.backgroundColor=""; 
          
          return true;
      }        
     
   
   }





  