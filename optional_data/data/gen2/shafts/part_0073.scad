$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 14, 10 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 14;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 10;                  // step 3 diameter
len3 = 15;                // step 3 length
total = 85;               // overall length
chamfer = 1.5;            // end chamfer
cross_d = 7;              // cross pin hole
cross_z = 77.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [10 - chamfer, 0], [10, chamfer], [10, 40], [7, 40], [7, 70], [5, 70], [5, 83.5], [3.5, 85], [0, 85]];

difference() {
  rotate_extrude() polygon(profile);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d3 + 4, d = cross_d, center = true);
}
