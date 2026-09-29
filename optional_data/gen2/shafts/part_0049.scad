$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 16, 14, 12 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 12;                  // step 4 diameter
len4 = 20;                // step 4 length
total = 110;              // overall length
chamfer = 1.5;            // end chamfer
cross_d = 4;              // cross pin hole
cross_z = 100;            // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [10 - chamfer, 0], [10, chamfer], [10, 25], [8, 25], [8, 65], [7, 65], [7, 90], [6, 90], [6, 108.5], [4.5, 110], [0, 110]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
