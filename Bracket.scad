
use <Mightyspidey-pmaa.ttf>

$fn=60;

Thickness=5;


//translate([0,0,0])
    Part_Back();
//translate([3+13+L2Lesc,0,-Vdrop-Thickness])
 //   Part_front();


// -----------------------------------------
// Back Part
// -----------------------------------------


// Back Mount
Hback       = 24;
Wback       = 21;   
H2Hback     = 94;
DholeBack   = 7;
pad_back    = 10;

// Back to Jacobi
Lback2TESC  = 34;
Wvertical   = 5;
Vdrop       = 12;

// Jacobi
DholeTESC   = 7;//5.5
H2Hesc      = 78;
L2Lesc      = 94;
overlap     = 5;
bumpUp      = 5.2;
bumpUpW     = 6.83-3.2;

module BackDrillTab()
    difference(){
        translate([-pad_back,0,0])
        square([Wback+pad_back,Hback+DholeBack/2+1]);    
        translate([0,Hback,0])
            circle(d=DholeBack);
    }
module BackVertical()
    union(){
        square([Wvertical,H2Hback+Hback*2]);
        translate([-Wvertical,Hback,0])
            square([Wvertical,H2Hback]);
    }
module TESC()
    difference(){
        square([Lback2TESC-Wback+overlap-Wvertical,H2Hback]);
        translate([Lback2TESC-Wback-Wvertical,(H2Hback-H2Hesc)/2,0])
            circle(d=DholeTESC);
        translate([Lback2TESC-Wback-Wvertical,H2Hback-(H2Hback-H2Hesc)/2,0])
            circle(d=DholeTESC);
    }
    
module TESCBumpUp()
    difference(){
        translate([bumpUpW,0,0])
            square([bumpUpW+overlap,H2Hback]);
        translate([Lback2TESC-Wback-Wvertical,(H2Hback-H2Hesc)/2,0])
            circle(d=DholeTESC);
        translate([Lback2TESC-Wback-Wvertical,H2Hback-(H2Hback-H2Hesc)/2,0])
            circle(d=DholeTESC);
    }

module Part_Back(){
    union(){
        translate([-Wback,0,0])
            linear_extrude(Thickness)
                BackDrillTab();
        translate([-Wback,H2Hback+Hback*2,0])
            mirror([0,1,0])
                linear_extrude(Thickness)
                    BackDrillTab();
        translate([0,0,-Vdrop-Thickness])
            linear_extrude(Vdrop+Thickness*2)
                BackVertical();
        translate([Wvertical,Hback,-Vdrop-Thickness])
            linear_extrude(Thickness)
                TESC();
        translate([Wvertical,Hback,-Vdrop])
            linear_extrude(bumpUp)
                TESCBumpUp();
    }
}


// -----------------------------------------
// Front Part
// -----------------------------------------

// front Mount
Hfront       = 23;
Wfront       = 40.5;   
H2Hfront     = 138;
Dholefront   = 11.5*1.04;
pad_front    = Dholefront/2+3;
tab_Height   = 15;

// front to Jacobi
Lfront2TESC  = 40.5;
FWvertical   = 4;
FVdropSpec   = 39-12.5+5.5;
FVdrop       = FVdropSpec - Thickness*2;
FVertLip     = 0;
Wcutout      =60;
Hcutout      =20;

H1 = (H2Hfront-(H2Hback+Hback*2))/2;

vertThick=Thickness*3.5+0.5;

module frontDrillTab()
    difference(){
        translate([0,0,0])
            square([Wfront+pad_front,Hfront]);    
        translate([Wfront,0,0])
            circle(d=Dholefront);
        translate([10,Hfront,0])
            polygon([[0,0],[30,0],[15,-5]]);
    }
module frontVertical()
    rotate([90,0,90])
        linear_extrude(vertThick)
            difference(){
                square([H2Hfront,FVdrop+Thickness*2+FVertLip]);
                polygon([[Hfront*1.8,0],
                        //[Hfront,tab_Height],
                        [H2Hfront/2-2,FVdrop+Thickness],
                        [H2Hfront/2+2,FVdrop+Thickness],
                        //[H2Hfront-Hfront,tab_Height],
                        [H2Hfront-Hfront*1.8,0]]);
            }



module Part_front(){
    difference(){
        union(){
        translate([FWvertical,-H1,-FVdrop-Thickness])
            linear_extrude(tab_Height)
                frontDrillTab();
        translate([FWvertical,H2Hfront-H1,-FVdrop-Thickness])
            mirror([0,1,0])
                linear_extrude(tab_Height)
                    frontDrillTab();
        translate([FWvertical-vertThick+Thickness,-H1,-FVdrop-Thickness])
            frontVertical();
        translate([9,20,0])    
        rotate([90,0,90])   
        linear_extrude(1)
        text("Rotary             Bladed", 4, font="mightyspidey:style=Medium");    
            
        translate([FWvertical,-H1,Thickness])
            cube([Thickness,H2Hfront,3]);
        translate([Wvertical-1,H2Hback+Hback,0])
            linear_extrude(Thickness)
                rotate([0,0,180])
                    TESC();
        translate([Wvertical-1,H2Hback+Hback,Thickness])
            linear_extrude(bumpUp)
                rotate([0,0,180])
                    TESCBumpUp();
        }
        translate([-10,H2Hfront-H1,-FVdropSpec])
            rotate([90,0,0])
                linear_extrude(H2Hfront)
                    polygon([[0,0],[0,FVdropSpec],[15,0]]);
        translate([-Wvertical+1,H2Hfront/2-H1+(H2Hesc/2),0])
            cylinder(h=40,d=DholeTESC,center=true);
        translate([-Wvertical+1,H2Hfront/2-H1-(H2Hesc/2),0])
            cylinder(h=40,d=DholeTESC,center=true);
            translate([-10,0,Thickness*2+2.5])
            rotate([0,90,0])
                linear_extrude(20)
                    polygon([[0,0],[0,25],[FVdropSpec-Thickness,0]]);
            translate([10,H2Hfront+4,Thickness*2+2.5])
            rotate([0,90,180])
                linear_extrude(20)
                    polygon([[0,0],[0,25],[FVdropSpec-Thickness,0]]);
        }

    
}


