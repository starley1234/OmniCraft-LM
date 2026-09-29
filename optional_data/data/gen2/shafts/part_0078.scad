$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 25, 20, 12, 10 mm, 130 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 25;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 20;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 25;                // step 4 length
d5 = 10;                  // step 5 diameter
len5 = 25;                // step 5 length
total = 130;              // overall length
chamfer = 2.5;            // end chamfer
groove_r = 12.5;          // groove radius
groove_z = 22;            // groove position from the end
groove_w = 2.5;           // groove width
groove_d = 2;             // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 19.6]) cylinder(h = 30.4, d = d2);
    translate([0, 0, 49.6]) cylinder(h = 30.4, d = d3);
    translate([0, 0, 79.6]) cylinder(h = 25.4, d = d4);
    translate([0, 0, 104.6]) cylinder(h = 25.4, d = d5);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([22.5, -2.5]) polygon([[0, 0], [5, 0], [5, 7.5], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([2.5, 130]) polygon([[0, 0], [5, -5], [5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
