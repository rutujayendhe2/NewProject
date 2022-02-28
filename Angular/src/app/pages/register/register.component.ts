import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { UsersService } from 'src/app/service/user.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  constructor(private usersService:UsersService) { }

  ngOnInit(): void {
  }
  onSubmit(form: NgForm) {
  //   console.log(f.value);  // { first: '', last: '' }
  //   console.log(f.valid);  // false


  this.usersService.addUsers(form.value.Firstname,
    form.value.lastname,
    form.value.email,
    form.value.Address,
    form.value.phoneNo,
    form.value.password,
    form.value.Confirmpassword,
)
alert('Registration Success');
}
}
