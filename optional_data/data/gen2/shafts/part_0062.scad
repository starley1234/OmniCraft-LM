$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 30, 16, 14, 10 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 30;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 40;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 10;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 15;                // step 4 length
total = 85;               // overall length
chamfer = 2.4;            // end chamfer
groove_r = 7;             // groove radius
groove_z = 62;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 1.3;           // groove depth
cross_d = 4;              // cross pin hole
cross_z = 77.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [15 - chamfer, 0], [15, chamfer], [15, 20], [8, 20], [8, 60], [7, 60], [7, 70], [5, 70], [5, 82.6], [2.6, 85], [0, 85]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d4 + 4, d = cross_d, center = true);
}
