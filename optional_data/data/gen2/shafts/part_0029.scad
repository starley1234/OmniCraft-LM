$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 30, 14, 12 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 30;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 65;               // overall length
chamfer = 1;              // end chamfer
groove_r = 7;             // groove radius
groove_z = 42;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.6;           // groove depth

difference() {
  /* turned body: stacked cylinders, every step sunk into the bigger one */
  union() {
    cylinder(h = len1, d = d1);
    translate([0, 0, 29.6]) cylinder(h = 10.4, d = d2);
    translate([0, 0, 39.6]) cylinder(h = 10.4, d = d3);
    translate([0, 0, 49.6]) cylinder(h = 15.4, d = d4);
  }
  /* bottom chamfer ring cut */
  rotate_extrude() translate([19, -2.5]) polygon([[0, 0], [3.5, 0], [3.5, 6], [0, 2.5]]);
  /* top chamfer ring cut */
  rotate_extrude() translate([5, 65]) polygon([[0, 0], [3.5, -3.5], [3.5, 2.5], [0, 2.5]]);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 2.5, groove_w]);
}
