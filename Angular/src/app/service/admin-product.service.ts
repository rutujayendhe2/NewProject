import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { map, Observable } from 'rxjs';
// import { IProduct } from '../pages/admin-product/IProduct';

@Injectable({
  providedIn: 'root'
})

export class AdminProductService {
  baseUrl='https://localhost:44362/api/Products';



  // httpOptions = {
  //   headers: new HttpHeaders({'Content-Type':'application/json'})
  // };


  constructor(private httpclient:HttpClient) { }

  createProduct(Products: any): Observable<any> {
    return this.httpclient.post(this.baseUrl, Products);
  }
 


  // createProduct(Products1: any):Observable<any>{
  //   console.log(Products1);
  //   return this.httpclient.post<any>
  //   ('https://localhost:44362/api/Products',Products1);  
  //   //  return this.httpclient.post<any>( `https://localhost:44392/api/Products1`, Products1)
  //   // .subscribe({
  //   //   next: (res) => {
  //   //     console.log(res);
  //   //   },
  //   //   error: (e) => console.error(e)
  //   // });
 
  // }
  

  delete(id: number):Observable<any>{
    return this.httpclient.delete<any>(`https://localhost:44362/api/Products/${id}`)
     }

  getProduct(){

    return this.httpclient.get<any>(`https://localhost:44362/api/Products`)
    .pipe(map((resp:any)=>{
      return resp;
   }))


 }

}

