import { Component, OnInit } from '@angular/core';
import { MediaService } from '../media.service';
import { delay } from 'rxjs/operators';

interface Media {
  id: number;
  type: string;
  title: string;
  author: string;
  end: string;
  start: string;
  user: string;
}

interface PastLoaning {
  start: string;
  end: string;
  user: string;
}

@Component({
  selector: 'app-medias',
  templateUrl: './medias.component.html',
  styleUrls: ['./medias.component.css']
})
export class MediasComponent implements OnInit {

  private filterTypeValue: string = '';
  private filterAuthorValue: string = '';
  mediasInit: Media[] = [];
  medias: Media[] = [];
  // user: string = '';
  showAvailable: boolean = false;
  pastLoanings: PastLoaning[] = [];
  historyIndex: number = -1;
  loadingIndex: number = -1;
  authenticatedUser: string = '';
  token = null;
  loginInfo: string = '';
  loaningInfo: string = '';

  constructor(private mediaService: MediaService) {
  }

  ngOnInit() {

    this.mediaService
      .getMedias()
      .pipe(
        delay(1000)
      )
      .subscribe((res: Media[]) => {
        this.mediasInit = res;
        this.medias = res;
      })

    this.mediaService
      .getPastLoanings()
      .subscribe((res: PastLoaning[]) => {
        this.pastLoanings = res;
      })
  }

  //saveLoaning(media_id: number, index: number, token: number) {
  saveLoaning(media_id: number, index: number) {
    this.loadingIndex = index;
    // envoyer requête d'enregistrement
    this.mediaService
      .newMediaLoaning(media_id, this.authenticatedUser, this.token)
      .pipe(
        delay(3000)
      )
      .subscribe((res: any) => {
        // mettre le DOM à jour (en mettant à jour this.medias)
        // index permet de récupérer le positionnement du media
        // dans le tableau this.medias
        if(res[0].result){
          this.medias[index].end = res.end;
          this.medias[index].user = this.authenticatedUser;
          this.loadingIndex = -1;
        }else{

          this.loginInfo = 'Emprunt Impossible !';
          this.loadingIndex = -1;
        }

      })
  }

  nbLoanings(): number {
    // if (this.user.length > 3) {
    if (this.authenticatedUser !== '') {
      let loanings: Media[] = [];
      loanings = this.medias
        .filter((media: Media) => media.user == this.authenticatedUser);
      return loanings.length;
    } else {
      return 0;
    }
  }

  filterType(val: string) {
    this.filterTypeValue = (val === '0')
      ? ''
      : val;
    this.filter();
  }

  filterAuthor(val: string) {
    if (val.length > 2) {
      this.filterAuthorValue = val;
    } else {
      this.filterAuthorValue = '';
    }
    this.filter();
  }

  private filter() {
    this.medias = this.mediasInit
      .filter((media: Media) => {

        let type: boolean = (this.filterTypeValue === '')
          ? true
          : media.type.toLowerCase() ===
            this.filterTypeValue.toLowerCase();

        let author: boolean = (this.filterAuthorValue === '')
          ? true
          : media.author.toLowerCase()
            .indexOf(this.filterAuthorValue.toLowerCase()) !== -1;

        return type && author;
      })
  }

  getPastLoaningsByUser(user: string): PastLoaning[] {
    let pastLoanings: PastLoaning[] =
      this.pastLoanings
        .filter((loaning: PastLoaning) => loaning.user === user);
    return pastLoanings;
  }

  login(pseudo: string, pwd: string) {
    this.mediaService.login(pseudo, pwd)
      .subscribe((res:any) => {
        if (res.token !== null) {
          this.authenticatedUser = pseudo;
          this.token = res.token;
          this.loginInfo = '';
        } else {
          this.loginInfo = 'Utilisateur ou mot de passe inconnu';
        }
      })
  }

  logout() {
    this.authenticatedUser = '';
  }

}
