import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroupDirective, NgForm, Validators } from '@angular/forms';
import { ErrorStateMatcher, ThemePalette } from '@angular/material/core';
import { ProgressBarMode } from '@angular/material/progress-bar';
import { CartService } from 'src/app/service/cart.service';
import { OrdersService } from 'src/app/service/order.service';
import { IOrder } from './IOrder';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.css']
})

export class OrderComponent implements OnInit {
  myModel = true;
  public productList: any[] = [];
  grandTotal = 0;

  order: IOrder = {
    id: 0,
    fullname: '',
    email: '',
    phone: '',
    city: '',
    zip: '',
    address: '',
    state: '',
    country: '',
    status: '',
    totalprice: this.cartservice.getTotalPrice(),
  };
  submitted = false;

  constructor(private orderservice: OrdersService, private cartservice: CartService) {

  }

  ngOnInit(): void {

    this.cartservice.getProducts().subscribe(data => {
      const d = this.productList = data;
      const totalprice = this.grandTotal = this.cartservice.getTotalPrice();
      console.log(d);
      console.log(totalprice);
      console.log("totalprice" + this.cartservice.getTotalPrice());
      
    })

  }

  saveOrder(): void {
    const data = {
      fullname: this.order.fullname,
      email: this.order.email,
      phone: this.order.phone,
      city: this.order.city,
      zip: this.order.zip,
      address: this.order.address,
      state: this.order.state,
      country: this.order.country,
      status: this.order.status,
      totalprice: this.order.totalprice,
      userId:localStorage.getItem("UserId")
    };

    this.orderservice.createOrder(data)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.submitted = true;
        },
        error: (e) => console.error(e)
      });


  }
  emptycart() {
    this.cartservice.removeAllCart();
  }
}
