// waterboy
thickness = 3;

module basescrews(){
    translate([0, -35,-0.01])
    cylinder(r=5/2, h=20, $fn=32);
    
    translate([0, -20,-0.01])
    cylinder(r=5/2, h=20, $fn=32);  
     
    // versenkungen
    translate([0, -20,-0.01])
    cylinder(r1=9/2, r2=5/2, h=4, $fn=32);
    
    translate([0, -35,-0.01])
    cylinder(r1=9/2, r2=5/2, h=4, $fn=32);
}

module loadcell(){
    // mounting-screws base: m5
    // mounting screws top: m4
    // length:8cm, width:13mm, height:13mm
    /*
    translate([0,0,thickness])
    cube([13,80,13]); // model the beam
    */
    
    cube([13,25,thickness]);// base
    
}

module base(){
    difference(){
        union(){
            cylinder(r=50+thickness, h=25+thickness, $fn=6);
        }
        translate([0,0,thickness+0.01])
        cylinder(r=50, h=30+thickness, $fn=6);        
    }
}


module top(){
    difference(){
        union(){
            cylinder(r=47, h=thickness, $fn=6);
            translate([-13/2, 40-25, -thickness])
            cube([13,25,thickness]);
        }
        translate([0,40-5,-10])
        cylinder(r=4.5/2, h=30, $fn=32);
        
        translate([0,40-20,-10])
        cylinder(r=4.5/2, h=30, $fn=32);
     
        
        translate([0,40-20,thickness-3.99])
        cylinder(r2=9/2,r1=4.5/2, h=4, $fn=32);       
        
        translate([0,40-5,thickness-3.99])
        cylinder(r2=9/2, r1=4.5/2, h=4, $fn=32);                 
    }
}

module motor(){
    // schraublöcher: 2.8cm hoch, 4mm durchmesser, 4.7cm abstand
    // schläuche: höhe: 9.3mm, abstand:17
    
    translate([0,-72+thickness,0])
    difference(){
        translate([-30-thickness,-20,0])
        difference(){
            union(){
                cube([60+2*thickness, 40+2*thickness, 40]);
                translate([36,-17,0])
                cube([15,17,30]);
            }
            translate([thickness, thickness, thickness])
            cube([60, 40, 40]);
            
            translate([36+2.5-0.5,-17+2-0.5,thickness])
            #cube([11,15.5,30]);            
        }

        // schrauben
        translate([47/2,-10,28+thickness])
        rotate([90,0,0])
        #cylinder(r=4.5/2, h=20, $fn=32);
        
        translate([-47/2,-10,28+thickness])
        rotate([90,0,0])
        #cylinder(r=4.5/2, h=20, $fn=32);        
        
        // schläuche
        translate([17/2,-10,9.3+thickness])
        rotate([90,0,0])
        #cylinder(r=5/2, h=20, $fn=32);
        
        translate([-17/2,-10,9.3+thickness])
        rotate([90,0,0])
        #cylinder(r=5/2, h=20, $fn=32);                
    }
}

module schlauchfuhrung_alt(){
        difference(){
            union(){
                cube([10,15,150]); 
                translate([0,0,150])
                rotate([45,0,0])
                #cube([10,80,10]);
            }
            translate([-0.01,7.5/2,-1])
            cube([8,7.5,157]);
            
            translate([-0.01,3.51,152.5])
            rotate([45,0,0])
            cube([8,78,5]);
        }
}

module schlauchfuhrung(){
    translate([5,5,0])
    rotate([0,0,360/6/2])
    difference(){
        cylinder(r=5.5, h=130, $fn=6);
        translate([0,0,-.5])
        cylinder(r=3, h=151, $fn=16);
        
        translate([-5.1,1.35,-7])
        rotate([0,0,-360/6/2])
        cube([3,2.8,140]);        
        
        translate([-4,1,3])
        cube([10,10,20]);
    }
    
    translate([5, -.25, -10])
    difference(){
        translate([0,55,140])
        rotate([0,90,0])
        rotate_extrude(angle=180, convexity=10)
        translate([50,0,0])
        circle(r=5.5, $fn=6);
        
        translate([0,55,140])
        rotate([0,90,0])
        rotate_extrude(angle=180, convexity=10)
        translate([50,0,0])
        circle(r=3, $fn=16);
        
        translate([-4,55,140])
        rotate([0,90,0])
        rotate_extrude(angle=180, convexity=10)
        translate([50,0,0])
        rotate([0,0,45])
        circle(r=2, $fn=4);
    
        
        translate([-50,-50,-60])
        cube([200,200,200]);
        
        translate([-50,50,-30])
        cube([200,200,200]);
    }
    
}

// base
difference(){
    union(){
        base();
        translate([-13/2,-40,thickness])
        loadcell();
        motor();
    }
    basescrews();
    // kabel-durchführung base zu motor
    translate([15,-35,thickness+4])
    rotate([90,0,0])
    #cylinder(r=4, h=20, $fn=32);
    
    translate([-15,-35,thickness+4])
    rotate([90,0,0])
    #cylinder(r=4, h=20, $fn=32);    
}


// straw
translate([5.5,-104,0])
schlauchfuhrung();



// simulate glass
translate([0,0,30+thickness])
%cylinder(r=85/2, h=100, $fn=32);


// topn
difference(){
    translate([0,0,28])
    top();
}

