import { Component, OnInit } from '@angular/core';
import { CartService } from 'src/app/service/cart.service';

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {

  public products : any[] = [];
  public grandtotal : number = 0 ;
  constructor(private cartService : CartService) { }

  ngOnInit(): void {
    this.cartService.getProducts()
    .subscribe((res:any)=>{
      this.products = res;
      this.grandtotal = this.cartService.getTotalPrice();
    })
  }
  removeItem(item : any){
    // console.log(item);
    this.cartService.removeCartItem(item);
    // console.log(item);
  }

  emptycart(){
    this.cartService.removeAllCart();
  }

}
