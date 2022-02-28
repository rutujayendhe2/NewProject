import { Component, Input, OnInit } from '@angular/core';
import { ApiService } from 'src/app/service/api.service';
import { CartService } from 'src/app/service/cart.service';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})

export class ProductComponent implements OnInit {

//property to store all the product list data comming from api /productlist
  public productList : any ;
  searchKey:string="";
  public filterCategory : any;
  pQuantity:any;

// To inject api service that is crreated
  constructor(private api : ApiService, private  cartService : CartService) { }


  ngOnInit(): void {
    this.api.getProduct()
        .subscribe(resp=>{
          console.log(resp);
          //to store resp data comming from api
          this.productList = resp ;
          this.filterCategory = resp;
      this.productList.forEach((a:any) => {
        Object.assign(a,{quantity:1,total:a.price})
      });
    })
    this.cartService.search.subscribe((val:any)=>{
      this.searchKey = val;
    })
  }

  addtocart(item: any,pQuantity:number){
    this.cartService.addtoCart(item,pQuantity);
  }

  filter(category:string){
    this.filterCategory = this.productList
    .filter((a:any)=>{
      if(a.category == category || category==''){
        return a;
      }
    })
  }

}

