class SortTime implements Comparable {
  int time;

  SortTime({this.time});

  @override
  int compareTo(other) {
    if(this.time == null || other == null) {
      return null;
    }

    if(this.time < other.time){
      return 1;
    }

    if(this.time > other.time) {
      return -1;
    }

    if(this.time == other.time) {
      return 0;
    }

    return null;
  }
}