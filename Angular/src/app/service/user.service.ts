import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UsersService {
  
//  baseUrl='http://localhost:3000/app'
url='https://localhost:44362/api/Users';

  constructor(private httpclient:HttpClient) { }



   getUsers():Observable <any>
  {
    return this.httpclient.get<any>('https://localhost:44362/api/Users');
    }

    addUsers(firstName:string,lastName:string,emailAdd:string,phoneNo:number,address:string,password:string,confirmPassword:string){

      const user={firstName:firstName,lastName:lastName,emailAdd:emailAdd,phoneNo:phoneNo,address:address,password:password,confirmPassword:confirmPassword};
      console.log(user);
      this.httpclient.post('https://localhost:44362/api/Users',user).subscribe(data=>{
  
        console.log(data);
  
      })
  
     }
}
