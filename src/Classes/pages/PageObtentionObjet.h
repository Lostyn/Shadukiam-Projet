//
//  PageObtentionObjet.h
//  ShadukiamGame
//
//  Created by yael on 04/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Page.h"
#import "Titre.h"
#import "FicheObjet.h"
#import "XMLReader.h"
#import "PageManager.h"
#import "InfosDisposition.h"

@interface PageObtentionObjet : Page {
    
    Titre *titre;
    FicheObjet *ficheObjet;
    int numObjet;
    NSDictionary *infosXML;
    
}

@end
