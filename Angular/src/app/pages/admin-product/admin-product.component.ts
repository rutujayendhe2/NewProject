import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AdminProductService } from 'src/app/service/admin-product.service';
import { IProduct } from './IProduct';

@Component({
  selector: 'app-admin-product',
  templateUrl: './admin-product.component.html',
  styleUrls: ['./admin-product.component.css']
})
export class AdminProductComponent implements OnInit {

  product : IProduct = {
    id: 0,
    title: '',
    price: 0,
    description: '',
    category: '',
    image: ''
  };
  

  submitted = false;
  // form: any;
  // form!: FormGroup;
  public Productlist:any;
  constructor(public productService: AdminProductService, private router : Router ) { }

  ngOnInit(): void {
    this.productService.getProduct().subscribe((res:any)=>{this.Productlist=res})
   }

   deleteProduct(id:number){

    if(confirm('are you want to delete order?')){

      this.productService.delete(id).subscribe(res=>{

        this.productService.getProduct().subscribe(data=>{

          this.Productlist=data;

        });
      });
    }
  }
   saveProduct(): void {
    const data = {

      title:this.product.title,
      price: this.product.price,
      description:this.product.description,
      category:this.product.category,
      image:this.product.image

    };
    //console.log(data);

    this.productService.createProduct(data)
      .subscribe({
        next: (res) => {
          console.log(res);
          this.submitted = true;
        },
        error: (e) => console.error(e)
      });

}
}
