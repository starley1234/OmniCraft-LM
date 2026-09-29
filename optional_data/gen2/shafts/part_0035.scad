$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 40, 10, 8 mm, 55 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 40;                  // step 1 diameter
len1 = 20;                // step 1 length
d2 = 10;                  // step 2 diameter
len2 = 25;                // step 2 length
d3 = 8;                   // step 3 diameter
len3 = 10;                // step 3 length
total = 55;               // overall length
chamfer = 2;              // end chamfer
groove_r = 5;             // groove radius
groove_z = 22;            // groove position from the end
groove_w = 3.5;           // groove width
groove_d = 1.6;           // groove depth
key_w = 4;                // keyway width
key_d = 2;                // keyway depth
key_len = 14;             // keyway length
key_z = 38;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [20 - chamfer, 0], [20, chamfer], [20, 20], [5, 20], [5, 45], [4, 45], [4, 53], [2, 55], [0, 55]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
