import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { map, Observable } from 'rxjs';
// const baseUrl = 'http://localhost:3000/app';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {
  
  
  

baseUrl='https://localhost:44362/api/Orders';

order_delete='https://localhost:44362/api/Orders';
httpOptions = {

headers: new HttpHeaders({ 'Content-Type': 'application/json' })

 };
  constructor(private httpclient:HttpClient) { }

  
  createOrder(Orders: any): Observable<any> {
    return this.httpclient.post(this.baseUrl, Orders);
  }
 
  

  }
