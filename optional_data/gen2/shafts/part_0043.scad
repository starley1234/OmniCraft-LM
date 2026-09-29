$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 20, 16, 12, 10 mm, 85 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 20;                  // step 1 diameter
len1 = 25;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 12;                  // step 3 diameter
len3 = 25;                // step 3 length
d4 = 10;                  // step 4 diameter
len4 = 10;                // step 4 length
total = 85;               // overall length
chamfer = 1.6;            // end chamfer
groove_r = 5;             // groove radius
groove_z = 77;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 2;             // groove depth
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 19;             // keyway length
key_z = 63;               // keyway start along the shaft
cross_d = 6;              // cross pin hole
cross_z = 12.5;           // cross hole position

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [10 - chamfer, 0], [10, chamfer], [10, 25], [8, 25], [8, 50], [6, 50], [6, 75], [5, 75], [5, 83.4], [3.4, 85], [0, 85]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
  /* cross pin hole through the small step */
  translate([0, 0, cross_z]) rotate([90, 0, 0]) cylinder(h = d1 + 4, d = cross_d, center = true);
}
