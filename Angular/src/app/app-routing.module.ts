import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { AboutUsComponent } from './pages/about-us/about-us.component';
import { ClassificationVegitablesComponent } from './pages/classification-vegitables/classification-vegitables.component';
import { LoginComponent } from './pages/login/login.component';
import { RegisterComponent } from './pages/register/register.component';
import { AdminLoginComponent } from './pages/admin-login/admin-login.component';
import { AdminHeaderComponent } from './pages/admin-header/admin-header.component';
// import { AdminUserService } from './service/admin-user.service';
import { AdminUserComponent } from './pages/admin-user/admin-user.component';
import { AdminProductComponent } from './pages/admin-product/admin-product.component';
import { AdminHomeComponent } from './pages/admin-home/admin-home.component';
import { AdminOrderComponent } from './pages/admin-order/admin-order.component';
import { ProductComponent } from './pages/product/product.component';
import { CartComponent } from './pages/cart/cart.component';
import { OrderComponent } from './pages/order/order.component';
import { PaymentComponent } from './pages/payment/payment.component';
import { AdminDashboardComponent } from './pages/admin-dashboard/admin-dashboard.component';
import { AuthguardService } from './service/authguard.service';

const routes: Routes = [
  {path: 'login', component: LoginComponent},
  {path: 'register', component: RegisterComponent},

  {path:"home",component:HomeComponent},
  {path:"aboutus",component:AboutUsComponent},
  {path:"classification-vegitables",component:ClassificationVegitablesComponent},
  {path: 'admin-login', component: AdminLoginComponent},
  {path: 'admin-header',component:AdminHeaderComponent},
  {path: 'admin-user',component:AdminUserComponent},
  {path: 'admin-order',component:AdminOrderComponent},
  {path: 'admin-product',component:AdminProductComponent},
  {path: 'admin-home',component:AdminHomeComponent},
  {path: 'admin-dashboard',component:AdminDashboardComponent},


  {path:'',redirectTo:'products',pathMatch:'full'},
//  {path:'products',component:ProductComponent},
  {path:'products',component:ProductComponent,canActivate:[AuthguardService]},
  {path:'cart',component:CartComponent},

  {path:'order',component:OrderComponent},
  {path:'payment',component:PaymentComponent},



];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [AuthguardService]
})
export class AppRoutingModule { }

