$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 16, 14, 10 mm, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 10;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 30;                // step 4 length
total = 80;               // overall length
chamfer = 2;              // end chamfer
cross_d = 7;              // cross pin hole
cross_z = 65;             // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 10], [8, 10], [8, 40], [7, 40], [7, 50], [5, 50], [5, 78], [3, 80], [0, 80]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
