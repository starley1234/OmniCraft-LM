$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 12, 10 mm, 110 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 25;                // step 4 length
total = 110;              // overall length
chamfer = 1.5;            // end chamfer
cross_d = 5;              // cross pin hole
cross_z = 97.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 30], [10, 30], [10, 60], [6, 60], [6, 85], [5, 85], [5, 108.5], [3.5, 110], [0, 110]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
