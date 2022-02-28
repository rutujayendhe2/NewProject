import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { UsersService } from 'src/app/service/user.service';

@Component({
  selector: 'app-admin-login',
  templateUrl: './admin-login.component.html',
  styleUrls: ['./admin-login.component.css']
})
export class AdminLoginComponent implements OnInit {
  form: any;
  users:[]=[];
  login!: string;
   
  constructor(private usersService:UsersService,private router:Router) { }

  ngOnInit(): void {
  }
  onSubmit(form: NgForm) {
    const emailAdd=form.value.email;
    const password=form.value.password;
    console.log(emailAdd,password);
    
    if(emailAdd === 'rutuja123@gmail.com' && password ==='12345'){
      this.router.navigate(['admin-dashboard'])
    }
    else{
      this.usersService.getUsers().subscribe(data=>{
        console.log(data);
        this.users=(data);
        
        if(data.emailAdd===emailAdd && data.password===password){
          console.log(data.emailAdd);
          this.login="sucssess";
          this.router.navigate(['home'])
        }
          else{
            this.login="Invalid username name"
        }

      });
    }
    

    

  }
}
