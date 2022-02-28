import { Component, OnInit } from '@angular/core';
import { AdminOrderServiceService } from 'src/app/service/admin-order-service.service';

@Component({
  selector: 'app-admin-order',
  templateUrl: './admin-order.component.html',
  styleUrls: ['./admin-order.component.css']
})
export class AdminOrderComponent implements OnInit {

  public Orderlist:any;

 constructor(private adminorderservice:AdminOrderServiceService) { }
ngOnInit(): void {

    this.adminorderservice.getOrders().subscribe((res:any)=>{this.Orderlist=res})

  }
  deleteOrder(id:number){

    if(confirm('are you want to delete order?')){

      this.adminorderservice.delete(id).subscribe(res=>{

        this.adminorderservice.getOrders().subscribe(data=>{

          this.Orderlist=data;

        });

      });

    }

  }
}
