//
//  FMColorMacro.h
//  Sample
//
//  Created by wjy on 2018/3/22.
//  Copyright © 2018年 wjy. All rights reserved.
//

#ifndef FMColorMacro_h
#define FMColorMacro_h

#define SRGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define SRGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SRGBCOLOR_HEX(hex) SRGBCOLOR(((hex & 0xFF0000 )>>16), ((hex & 0x00FF00 )>>8), (hex & 0x0000FF))

#endif /* FMColorMacro_h */
