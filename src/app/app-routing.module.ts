import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminPanelComponent } from './admin-panel/admin-panel.component';
import { AdminProductComponent } from './admin-product/admin-product.component';
import { AdminRemediesComponent } from './admin-remedies/admin-remedies.component';
import { AdminHealthTipsComponent } from './admin-health-tips/admin-health-tips.component';
import { AdminUserDetailsComponent } from './admin-user-details/admin-user-details.component';
import { AdminManagementComponent } from './admin-management/admin-management.component';
import { AdminProfileComponent } from './admin-profile/admin-profile.component';
import { AdminProductFormComponent } from './admin-product-form/admin-product-form.component';
import { AdminRemedyFormComponent } from './admin-remedy-form/admin-remedy-form.component';

// Updated routes configuration
const routes: Routes = [
  { path: '', redirectTo: '/admin-panel', pathMatch: 'full' },
  { path: 'admin-panel', component: AdminPanelComponent },

  // Admin Product Routes
  { path: 'admin-product', component: AdminProductComponent },
  { path: 'admin-product-form', component: AdminProductFormComponent },

  // Admin Remedies Routes
  { path: 'admin-remedies', component: AdminRemediesComponent },
  { path: 'admin-remedies-form', component:AdminRemedyFormComponent},  


  // Other admin routes
  { path: 'admin-health-tips', component: AdminHealthTipsComponent },
  { path: 'admin-user-details', component: AdminUserDetailsComponent },
  { path: 'admin-management', component: AdminManagementComponent },
  { path: 'admin-profile', component: AdminProfileComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
