import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AdminRemedyFormComponent } from './admin-remedy-form.component';

describe('AdminRemedyFormComponent', () => {
  let component: AdminRemedyFormComponent;
  let fixture: ComponentFixture<AdminRemedyFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [AdminRemedyFormComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(AdminRemedyFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
