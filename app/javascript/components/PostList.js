import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
class PostList extends React.Component {
  render () {
    return (
      <div>
        {this.props.posts.map((post) => {
          return (<Post key={post.id} title={post.title} body={post.body}></Post>)
        })}
      </div>
    );
  }
}

PostList.propTypes = {
  posts: PropTypes.array
};
export default PostList
