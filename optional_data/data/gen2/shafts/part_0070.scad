$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 20, 16, 14, 12 mm, 115 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 16;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 14;                  // step 4 diameter
len4 = 20;                // step 4 length
d5 = 12;                  // step 5 diameter
len5 = 15;                // step 5 length
total = 115;              // overall length
chamfer = 2;              // end chamfer
cross_d = 6;              // cross pin hole
cross_z = 107.5;          // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 30], [10, 30], [10, 55], [8, 55], [8, 80], [7, 80], [7, 100], [6, 100], [6, 113], [4, 115], [0, 115]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d5 + 4, d = cross_d, center = true);
}
