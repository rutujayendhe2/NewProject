import { Component, OnInit } from '@angular/core';
import { NgForm, Validators } from '@angular/forms';
import { UsersService } from 'src/app/service/user.service';
import * as CryptoJS from 'crypto-js';
import { Router } from '@angular/router';
import { HttpClient, HttpClientJsonpModule } from '@angular/common/http';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  form: any;
  users:[]=[];
  login!: string;
  isvalidlogin=false

  constructor(private usersService:UsersService,private router:Router,private http:HttpClient) { }

  ngOnInit(): void {
  }
  onSubmit(form: NgForm) {

    const user={EmailAdd:form.value.email,password:form.value.password};

    console.log(user);
    this.http.post("https://localhost:44362/api/Auth/login",user).subscribe((response:any)=>{

     const token=response.tokenString;
     const userId=response.userId;
     console.log(response);
     


      localStorage.setItem("jwt",token);
      localStorage.setItem("UserId",userId);

       this.isvalidlogin=true;

     this.router.navigate(["home"]);



    },err=>{this.isvalidlogin=false});

  }
}
