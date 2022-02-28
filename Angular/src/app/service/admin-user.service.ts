import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminUserService {
 

  constructor(private httpclient:HttpClient) { }
  getUsers() {
    return this.httpclient.get<any>('https://localhost:44362/api/Users')
    .pipe(map((res:any)=>{return res;}))
  }


  delete(id: number):Observable<any>{

    return this.httpclient.delete<any>(`https://localhost:44362/api/Users/${id}`)
    
     }
}
