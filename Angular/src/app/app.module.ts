import { NgModule } from '@angular/core';

import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { BrowserModule } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AppComponent } from './app.component';
import { FooterComponent } from './pages/footer/footer.component';
import { HeaderComponent } from './pages/header/header/header.component';
import { HomeComponent } from './pages/home/home.component';
import { AboutUsComponent } from './pages/about-us/about-us.component';
import { AppRoutingModule } from './app-routing.module';
import { LoginComponent } from './pages/login/login.component';
import { ClassificationVegitablesComponent } from './pages/classification-vegitables/classification-vegitables.component';
import { RegisterComponent } from './pages/register/register.component';
import { SliderComponent } from './pages/slider/slider.component';
import { FrontendDashboardComponent } from './pages/frontend-dashboard/frontend-dashboard.component';
import { AdminDashboardComponent } from './pages/admin-dashboard/admin-dashboard.component';
import { AdminHeaderComponent } from './pages/admin-header/admin-header.component';
import { AdminLoginComponent } from './pages/admin-login/admin-login.component';
// import { AdminUserComponent } from './pages/admin-user/admin-user.component';
import { AdminOrderComponent } from './pages/admin-order/admin-order.component';
import { AdminProductComponent } from './pages/admin-product/admin-product.component';
import { AdminUserComponent } from './pages/admin-user/admin-user.component';
import { AdminHomeComponent } from './pages/admin-home/admin-home.component';
//material
import {MatInputModule} from '@angular/material/input';
import {MatButtonModule} from '@angular/material/button';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {MatRadioModule} from '@angular/material/radio';
import {MatProgressBarModule} from '@angular/material/progress-bar';
import {MatSidenavModule} from '@angular/material/sidenav';
import {MatListModule} from '@angular/material/list';
import {MatIconModule} from '@angular/material/icon';
import {MatExpansionModule} from '@angular/material/expansion';
import {MatDividerModule} from '@angular/material/divider';
import { MatSliderModule } from '@angular/material/slider';

import {MatFormFieldModule} from '@angular/material/form-field';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { OrderComponent } from './pages/order/order.component';
import { ProductComponent } from './pages/product/product.component';
import { CartComponent } from './pages/cart/cart.component';
import { PaymentComponent } from './pages/payment/payment.component';
import { FilterPipe } from './shared/filter.pipe';
import { JwtModule } from '@auth0/angular-jwt';
import { AuthguardService } from './service/authguard.service';
import { AuthInterceptor } from './authInterceptor';
import { ViewProductComponent } from './pages/view-product/view-product.component';


// import { MatFormFieldModule } from '@angular/material/form-field/form-field-module';
export function tokenGetter(){

  return localStorage.getItem("jwt");

}

@NgModule({
  declarations: [
    AppComponent,
    FooterComponent,
    HeaderComponent,
    HomeComponent,
    AboutUsComponent,
    LoginComponent,
    
    ClassificationVegitablesComponent,
    RegisterComponent,
    SliderComponent,
    FrontendDashboardComponent,
    AdminDashboardComponent,
    AdminHeaderComponent,
    AdminLoginComponent,
    AdminUserComponent,
    AdminOrderComponent,
    AdminProductComponent,
    AdminHomeComponent,
    OrderComponent,
    ProductComponent,
    CartComponent,
    PaymentComponent,
    FilterPipe,
    ViewProductComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    CommonModule,
    ReactiveFormsModule,
    FormsModule,
    HttpClientModule,
    MatFormFieldModule,
    MatInputModule, 
    MatButtonModule, 
    MatCheckboxModule, 
    MatRadioModule, 
    MatProgressBarModule, 
    MatSliderModule, 
    MatIconModule, 
    MatDividerModule, 
    MatSidenavModule,
    MatListModule, 
    MatExpansionModule,
    BrowserAnimationsModule,
    JwtModule


  ],
  providers: [{provide:HTTP_INTERCEPTORS,useClass:AuthInterceptor,multi:true}],
  bootstrap: [AppComponent]
})
export class AppModule { }
