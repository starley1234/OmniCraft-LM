$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 12, 8 mm, 75 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 15;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 30;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 15;                // step 4 length
total = 75;               // overall length
chamfer = 2;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 67.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 15], [8, 15], [8, 30], [6, 30], [6, 60], [4, 60], [4, 73], [2, 75], [0, 75]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
