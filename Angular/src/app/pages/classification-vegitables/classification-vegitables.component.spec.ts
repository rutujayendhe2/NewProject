import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ClassificationVegitablesComponent } from './classification-vegitables.component';

describe('ClassificationVegitablesComponent', () => {
  let component: ClassificationVegitablesComponent;
  let fixture: ComponentFixture<ClassificationVegitablesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ClassificationVegitablesComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ClassificationVegitablesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
