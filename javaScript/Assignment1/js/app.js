const book=function(bookid,bookName,authorName){
        this.bookid=bookid;  
        this.bookName=bookName;
        this.authorName=authorName;
        this.getDetais=function(){
        return this.bookid+", "+
        this.bookName+" ,"+
        this.authorName;
        }}
    const book1=new book(1565,"Mockingjay","Suzanne collins");
    document.getElementById("result").innerHTML="<mark>"+book1.getDetais()+"</mark>";
