import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { JwtHelperService, JwtModule } from '@auth0/angular-jwt';
import { Observable } from 'rxjs';
import { tokenGetter } from '../app.module';


JwtModule.forRoot({

  config:{

    tokenGetter:tokenGetter,

    allowedDomains:["localhost:44362"],

    disallowedRoutes:[]

  }

})

@Injectable({
  providedIn: 'root'
})
export class AuthguardService {


  constructor(private router:Router,private jwtHelper:JwtHelperService) 
  { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): boolean | UrlTree | Observable<boolean | UrlTree> | Promise<boolean | UrlTree> {

   const token=localStorage.getItem("jwt");

   if(token && this.jwtHelper.isTokenExpired(token))

   {

     return true;

   }
   else
   {

   this.router.navigate(["/login"]);

   return false;
   }
  }
}
