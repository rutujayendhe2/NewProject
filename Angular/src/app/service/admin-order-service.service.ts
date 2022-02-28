import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminOrderServiceService {
  baseUrl='https://localhost:44362/api/Orders';

  baseUrldelete='https://localhost:44362/api/Orders';

order_delete='https://localhost:44362/api/Orders';

httpOptions = {



headers: new HttpHeaders({ 'Content-Type': 'application/json' })



 };
 constructor(private httpclient:HttpClient) { }





  getOrders(){

    return this.httpclient.get<any>("https://localhost:44362/api/Orders")

    .pipe(map((resp:any)=>{

      return resp;

   }))

 }



 delete(id: number):Observable<any>{

return this.httpclient.delete<any>(`https://localhost:44362/api/Orders/${id}`)

 }}
