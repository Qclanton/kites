<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>

<div class="comment">
                    <div class="title">
                        <span class="name"><?php echo $review['author']; ?></span>
                        <span class="time"><?php echo $review['date_added']; ?></span>
                        <span class="name">|</span>
                    </div>
                    <div class="text">
			<?php echo $review['text']; ?>
                    </div>
                </div>
<?php } ?>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<div class="content"><?php echo $text_no_reviews; ?></div>
<?php } ?>
