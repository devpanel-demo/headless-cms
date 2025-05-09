import { State } from './../../../models/state.model';
import { Store } from '@ngrx/store';
import { Recipe } from 'contenta-angular-service';
import { Observable } from 'rxjs/Observable';
import { Component, OnInit } from '@angular/core';
import { environment } from './../../../../environments/environment';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  promotedRecipes: Observable<Array<Recipe>>;
  baseUrl = environment.baseUrl;

  constructor(private store: Store<State>) {
    this.promotedRecipes = store.select('app', 'promoted');
  }

  ngOnInit() {
  }

}
