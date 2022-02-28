import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})

export class CartService {

  public cartItemList : any = [];
  public productList = new BehaviorSubject<any>([]);
  public search = new BehaviorSubject<string>("");

  constructor() { }

  getCartList(){
    return this.cartItemList.asObservable();
  }

  getProducts(){
    return this.productList.asObservable();
  }

  setProduct(product : any){
    this.cartItemList.push(...product);
    // to emit data
    this.productList.next(product);
  }

  addtoCart(product : any,pQuantity:number){
    const _product={product:product,quantity:pQuantity};
    this.cartItemList.push(_product);
    this.productList.next(this.cartItemList);
    this.getTotalPrice();
  }

  getTotalPrice() : number{
    let grandTotal = 0;
    this.cartItemList.map((a:any)=>{
      const q:number=parseInt(a.quantity );
        grandTotal += a.product.total*q;
    })
    return grandTotal;
  }
  removeCartItem(product : any){
    this.cartItemList.map((a:any, index:any)=>{
      if(product.id===a.id){
        this.cartItemList.splice(index,1);
      }
    })
    this.productList.next(this.cartItemList)
  }

  removeAllCart(){
    this.cartItemList = []
    this.productList.next(this.cartItemList);
  }

}


function quantity(a: any, quantity: any): number {
  throw new Error('Function not implemented.');
}
