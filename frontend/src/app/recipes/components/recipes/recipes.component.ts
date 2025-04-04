import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Recipe } from 'contenta-angular-service';
import { environment } from './../../../../environments/environment';

@Component({
  selector: 'app-recipes-cmp',
  templateUrl: './recipes.component.html',
  styleUrls: ['./recipes.component.scss']
})
export class RecipesComponent {
  @Input() recipes: Array<Recipe>;
  @Output() onIncrementList = new EventEmitter();
  scrollContainerClass = '.recipes .sidenav-con .mat-sidenav-content';
  baseUrl= environment.baseUrl;;

  incrementListSize() {
    this.onIncrementList.emit();
  }
}
