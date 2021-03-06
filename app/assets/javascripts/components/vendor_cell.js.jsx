const VendorCell = React.createClass({

  formattedRating: function(rating) {
    var formattedRating = 0

    if ( rating != "n/a" ) {
      formattedRating = rating.toFixed(1)
    } else {
      formattedRating = "n/a"
    }

    return formattedRating
  },

  render: function() {
    return(
      <div className='cell'>

        <div className='text-container'>

            <div className='title'><a href={'/vendors/'+this.props.vendor.vendor_id}>{this.props.vendor.vendor_name}</a></div>
            <div className='sub-title'>
              <span>{this.props.vendor.vendor_reviews_count} reviews</span>

            </div>
        </div>

        <div className="right-container">
          <div className="right-decorator">
            <div>
              <span><img className='big-star' src="/assets/big-star.png"></img><span className='score'>{this.formattedRating(this.props.vendor.vendor_avg_rating)}</span></span>
            </div>
          </div>
        </div>

      </div>
    )
  }

})
