 import { Component, OnInit } from '@angular/core';

import { AdminUserService } from "src/app/service/admin-user.service";

@Component({
  selector: 'app-admin-user',
  templateUrl: './admin-user.component.html',
  styleUrls: ['./admin-user.component.css']
})
export class AdminUserComponent implements OnInit {

//   constructor() { }

//   ngOnInit(): void {
//   }

  public userList:any;
 constructor(private adminuserservice:AdminUserService) { }


ngOnInit(): void {
  this.adminuserservice.getUsers()
  .subscribe((res:any)=>{
    this.userList=res;
  })
  
}
deleteUser(id:number){

  if(confirm('are you want to delete order?')){

    this.adminuserservice.delete(id).subscribe(_res=>{

      this.adminuserservice.getUsers().subscribe(data=>{

        this.userList=data;

      });

    });

  }

}
}
