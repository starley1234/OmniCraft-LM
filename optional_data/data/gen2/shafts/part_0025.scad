$fn = 32;

// ----------------------------------------------------------------------
// Stepped shaft: diameters 25, 16, 14, 8 mm, 125 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
d1 = 25;                  // step 1 diameter
len1 = 40;                // step 1 length
d2 = 16;                  // step 2 diameter
len2 = 30;                // step 2 length
d3 = 14;                  // step 3 diameter
len3 = 15;                // step 3 length
d4 = 8;                   // step 4 diameter
len4 = 40;                // step 4 length
total = 125;              // overall length
chamfer = 1;              // end chamfer
groove_r = 4;             // groove radius
groove_z = 87;            // groove position from the end
groove_w = 3;             // groove width
groove_d = 2;             // groove depth
key_w = 6;                // keyway width
key_d = 3;                // keyway depth
key_len = 34;             // keyway length
key_z = 88;               // keyway start along the shaft

/* closed turning profile: x is the radius, y is the length */
profile = [[0, 0], [12.5 - chamfer, 0], [12.5, chamfer], [12.5, 40], [8, 40], [8, 70], [7, 70], [7, 85], [4, 85], [4, 124], [3, 125], [0, 125]];

difference() {
  rotate_extrude() polygon(profile);
  /* circlip groove just behind the shoulder */
  rotate_extrude() translate([groove_r - groove_d, groove_z]) square([groove_d + 1, groove_w]);
  /* keyway milled into the top of the largest step */
  translate([d1 / 2 - key_d, -key_w / 2, key_z]) cube([key_d + 1, key_w, key_len]);
}
