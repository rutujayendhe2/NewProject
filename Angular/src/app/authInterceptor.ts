import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from "@angular/common/http";
import { Observable } from "rxjs";

export class AuthInterceptor implements HttpInterceptor
{
    token:any;
    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        this.token = localStorage.getItem('jwt');
        const authRequest = req.clone({
            headers : req.headers.set("Authorization","Bearer "+ this.token )
        });
        return next.handle(authRequest);
    }
    
}