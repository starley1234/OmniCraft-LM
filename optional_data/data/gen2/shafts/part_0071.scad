$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 12, 8 mm, 45 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 15;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 10;                // step 4 length
total = 45;               // overall length
chamfer = 2;              // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 40;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 15], [8, 15], [8, 25], [6, 25], [6, 35], [4, 35], [4, 43], [2, 45], [0, 45]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
