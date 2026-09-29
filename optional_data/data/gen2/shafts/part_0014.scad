$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 50, 20, 12 mm, 65 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 50;                  // step 1 diameter
len1 = 30;                // step 1 length
d2 = 20;                  // step 2 diameter
len2 = 10;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
total = 65;               // overall length
chamfer = 2;              // end chamfer
cross_d = 6;              // cross pin hole
cross_z = 52.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [25 - chamfer, 0], [25, chamfer], [25, 30], [10, 30], [10, 40], [6, 40], [6, 63], [4, 65], [0, 65]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
